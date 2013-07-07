core = require('./core')
# 電熱水瓶

# form type:
#     S1:
# form url:
#     '/purchasing/compare/electric_boiler.asp'

# S1
# 熱水容量
# 101. 機械式
# 102. 微電腦式

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 101, 102]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/electric_boiler.asp'

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
