utility = require './utility'
getCompletions = require './get-completions'
getIssues = require './get-issues'

module.exports =
  selector: '*'
  inclusionPriority: 2
  suggestionPriority: 2
  excludeLowerPriority: false

  grammarScopes: ['*']
  scope: 'file'
  lintOnFly: true

  getSuggestions: (context) ->
    return [] unless utility.isEnabledForScope context.scopeDescriptor
    getCompletions(context).catch utility.notifyError []

  lint: (editor) ->
    return [] unless utility.isEnabledForScope editor.getRootScopeDescriptor()
    return [] unless atom.config.get 'you-complete-me.linterEnabled'
    getIssues(editor).catch utility.notifyError []
