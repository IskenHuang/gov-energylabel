core = require('./core')

# form type:
#     S1:
# form url:
#     '/purchasing/compare/clothing_drier.asp'

# S1
# 乾衣機容量
# 1. 小於10公斤
# 2. 大於10公斤

exports = module.exports =

    getData: ->
        _data = []
        for i in [1..2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/clothing_drier.asp'

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
