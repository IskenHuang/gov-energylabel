core = require('./core')
# 儲備型電熱水器

# form type:
#     S1:
# form url:
#     '/purchasing/compare/stock_Electric_Boiler.asp'

# S1
# 熱水容量
# 1. 六十公升以下
# 2. 六十公升(含)以上

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 1, 2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/stock_Electric_Boiler.asp'

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
