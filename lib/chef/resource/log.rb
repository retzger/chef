#
# Author:: Cary Penniman (<cary@rightscale.com>)
# Author:: Tyler Cloke (<tyler@chef.io>)
# Copyright:: Copyright 2008-2016, Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/resource"
require "chef/provider/log"

class Chef
  class Resource
    class Log < Chef::Resource

      identity_attr :message

      default_action :write

      # Sends a string from a recipe to a log provider
      #
      # log "some string to log" do
      #   level :info  # (default)  also supports :warn, :debug, and :error
      # end
      #
      # === Example
      # log "your string to log"
      #
      # or
      #
      # log "a debug string" { level :debug }
      #

      # Initialize log resource with a name as the string to log
      #
      # === Parameters
      # name<String>:: Message to log
      # collection<Array>:: Collection of included recipes
      # node<Chef::Node>:: Node where resource will be used
      def initialize(name, run_context = nil)
        super
        @level = :info
        @message = name
        @update_resource_count = true
      end

      def message(arg = nil)
        set_or_return(
          :message,
          arg,
          :kind_of => String
        )
      end

      # <Symbol> Log level, one of :debug, :info, :warn, :error or :fatal
      def level(arg = nil)
        set_or_return(
          :level,
          arg,
          :equal_to => [ :debug, :info, :warn, :error, :fatal ]
        )
      end

      def update_resource_count(arg = nil)
        set_or_return(
          :update_resource_count,
          arg,
          :kind_of => [TrueClass, FalseClass]
        )
      end

    end
  end
end
