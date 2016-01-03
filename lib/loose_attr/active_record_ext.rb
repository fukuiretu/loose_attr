module LooseAttr
  module ActiveRecordExt
    def self.included(model)
      model.class_eval do
        before_save :set_ext_field
        after_find  :set_hashed_ext
      end
      model.extend ClassMethods
    end

    module ClassMethods
      def loose_attr(name, cast_type: :string, default_value: nil)
        # read attr
        define_method name do
          value = hashed_ext.send(name.to_s) || default_value
          cast(value, cast_type)
        end

        # write attr
        define_method "#{name}=" do |value|
          hashed_ext.send("#{name}=", value)
        end
      end

      def modify_loose_attr_column_name(name)
        @loose_attr_column_name = name.to_sym
      end

      def loose_attr_column_name
        @loose_attr_column_name ||= 'ext_field'
      end
    end

    private

      def hashed_ext
        @hashed_ext ||= ::Hashie::Mash.new
      end

      def set_ext_field
        self.send("#{self.class.loose_attr_column_name}=", hashed_ext.to_json) if hashed_ext.present?
      end

      def set_hashed_ext
        ext_field = read_attribute(self.class.loose_attr_column_name)
        @hashed_ext = ::Hashie::Mash.new(JSON.parse(ext_field)) if ext_field.present?
      end

      def cast(value, cast_type)
        return nil if value.blank?

        case cast_type
        when :string
          value.to_s
        when :integer
          value.to_i
        when :boolean
          value.to_b
        end
      end
  end
end
