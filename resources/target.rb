actions :create, :delete
default_action :create

attribute :mode, :kind_of => String, :default => 'rsync'
attribute :source, :kind_of => String, :required => true
attribute :target, :kind_of => String, :required => true
attribute :delete, :kind_of => [String, NilClass, TrueClass, FalseClass]
attribute :user, :kind_of => [String, NilClass]
attribute :host, :kind_of => [String, NilClass]
attribute :rsync_opts, :kind_of => [Array, NilClass]
attribute :rsync, :kind_of => [Hash, NilClass]
attribute :exclude, :kind_of => [Array, NilClass]
attribute :exclude_from, :kind_of => [String, NilClass]
attribute :cookbook, :kind_of => String, :default => 'lsyncd'
