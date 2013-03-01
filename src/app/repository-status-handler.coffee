Git = require 'git'
fs = require 'fs'

module.exports =
  loadStatuses: (path) ->
    repo = Git.open(path)
    if repo?
      workingDirectoryPath = repo.getWorkingDirectory()
      statuses = {}
      for path, status of repo.getRepo().getStatuses()
        statuses[fs.join(workingDirectoryPath, path)] = status
      upstream = repo.getAheadBehindCounts() ? {ahead: 0, behind: 0}
      repo.destroy()
    else
      upstream = {}
      statuses = {}

    callTaskMethod('statusesLoaded', {statuses, upstream})
