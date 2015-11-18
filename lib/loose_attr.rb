require "active_record"
require "loose_attr/active_record_ext"

module LooseAttr
end
# ActiveRecord::Base.extend LooseAttr::ActiveRecordExt
ActiveRecord::Base.send(:include, LooseAttr::ActiveRecordExt)
