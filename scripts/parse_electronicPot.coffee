core = require('./core')
# 電鍋

# form type:
#     S1:
#     S2:
# form url:
#     '/purchasing/compare/electronic_pot.asp'

# S1
# 電鍋種類
# 95. 直接加熱式(電子鍋)
# 94. 間接加熱式(電鍋)

# S2
# 選擇電鍋容量
# 1. 小於六人份
# 2. 大於六人份

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 94, 95]
            for j in [ 1, 2]
                _data.push
                    S1: i
                    S2: j

        return _data

    rootURL: '/purchasing/compare/electronic_pot.asp'

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
