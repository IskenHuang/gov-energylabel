core = require('./core')

# form type:
#     T1:
# form url:
#     '/purchasing/compare/refrigerator.asp'

# T1
# 家庭人數
# [1..20]

exports = module.exports =

    getData: ->
        _data = []
        for i in [1..20]
            _data.push
                T1: i

        return _data

    rootURL: '/purchasing/compare/refrigerator.asp'

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
