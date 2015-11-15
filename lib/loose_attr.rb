require "active_record"
require "loose_attr/active_record_ext"

module LooseAttr
end
ActiveRecord::Base.send(:include, LooseAttr::ActiveRecordExt)
