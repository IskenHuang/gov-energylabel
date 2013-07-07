core = require('./core')
# 室內照明燈具

# form type:
#     S1:
# form url:
#     '/purchasing/compare/lamps.asp'

# S1
# 型式
# 1. <=65公分
# 2. >65公分

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 1, 2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/lamps.asp'

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
