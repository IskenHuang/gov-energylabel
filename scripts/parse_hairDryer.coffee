core = require('./core')

# form type:
#     S1:
# form url:
#     '/purchasing/compare/hair_dryer.asp'

# S1
# 吹風機口徑
# 1. 50mm
# 2. >=50mm
# [1..2]

exports = module.exports =

    getData: ->
        _data = []
        for i in [1, 2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/hair_dryer.asp'

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
