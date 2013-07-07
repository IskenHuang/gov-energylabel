core = require('./core')
# 溫熱型飲水機

# form type:
#     S1:
# form url:
#     '/purchasing/compare/drinking_HW.asp'

# S1
# 熱水容量
# 1. 十五公升以上
# 2. 低於十五公升

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 1, 2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/drinking_HW.asp'

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
