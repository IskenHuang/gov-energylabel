core = require('./core')

# form type:
#     T1:
# form url:
#     '/purchasing/compare/clothes_washer.asp'

# washer
# 洗衣容量
# 1. 小於10公斤
# 2. 10~13公斤
# 3. 14公斤以上
# [1..3]

exports = module.exports =

    getData: ->
        _data = []
        for i in [1..3]
            _data.push
                washer: i

        return _data

    rootURL: '/purchasing/compare/clothes_washer.asp'

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
