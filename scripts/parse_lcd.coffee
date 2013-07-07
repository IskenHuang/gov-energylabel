core = require('./core')
# LCD電腦螢幕

# form type:
#     S1:
# form url:
#     '/purchasing/compare/lcd.asp'

# S1
# LCD電腦螢幕型式
# 1.  小於1百萬像素
# 2.  大於等於1百萬像素

exports = module.exports =

    getData: ->
        _data = []
        for i in [1, 2]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/lcd.asp'

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
