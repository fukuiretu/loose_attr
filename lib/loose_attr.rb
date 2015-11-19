require "active_record"
require "hashie"
require "wannabe_bool"
require "loose_attr/active_record_ext"

module LooseAttr
end

ActiveRecord::Base.send(:include, LooseAttr::ActiveRecordExt)
