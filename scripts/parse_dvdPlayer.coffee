core = require('./core')
# DVD PLAYER

# form type:
#     S1:
# form url:
#     '/purchasing/compare/DVD_PLAYER.asp'

# S1
# 型式
# 114. DVD放影機
# 115. DVD錄放影機

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 114, 115]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/DVD_PLAYER.asp'

    parse: (options = { source: 'http' })->
        if options.source is 'file'
            for i in @getData()
                core.getFileFromArray
                    path: options.path
                , (result)->
                    console.log 'result = ', result
        else
            for i in @getData()
                core.getHTTPFromArray
                    url: @rootURL
                    body: i
                , (result)->
                    console.log 'result = ', result
