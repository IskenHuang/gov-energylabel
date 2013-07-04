core = require('./core')

# form type:
#     T1:
# form url:
#     '/purchasing/compare/dehumidifier.asp'

# T1
# 空間坪數
# 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100

exports = module.exports =

    getData: ->
        _data = []
        i = 0
        while i < 100
            _data.push
                T1: i

            i += 5

        return _data

    rootURL: '/purchasing/compare/dehumidifier.asp'

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
