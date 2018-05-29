require 'redmine'

require_dependency 'redmine_hangouts_chat/listener'

Redmine::Plugin.register :redmine_hangouts_chat do
	name 'Redmine Hangouts Chat'
	author 'Samuel Cormier-Iijima'
	url 'https://github.com/patope/redmine-hangouts-chat'
	description 'Google Hangouts Chat integration'
	version '0.2'

	requires_redmine :version_or_higher => '0.8.0'

	settings \
		:default => {
			'callback_url' => 'https://chat.googleapis.com/v1/',
			'channel' => nil,
			'username' => 'redmine',
			'display_watchers' => 'no'
		},
		:partial => 'settings/slack_settings'
end

ActionDispatch::Callbacks.to_prepare do
	require_dependency 'issue'
	unless Issue.included_modules.include? RedmineHangoutsChat::IssuePatch
		Issue.send(:include, RedmineHangoutsChat::IssuePatch)
	end
end
