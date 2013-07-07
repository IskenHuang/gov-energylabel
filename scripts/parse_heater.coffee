core = require('./core')

# form type:
#     hT:
#     aT:
#     useTime:
#     ngp:
#     lpgp:
# form url:
#     '/purchasing/compare/heater.asp'

# hT
# 熱水器型式
# 1. RF(室外式)
# 2. CF(自然通風型)
# 3. FE(強制排器型-室內型)

# aT
# 燃氣別
# 1. NG(天然氣)
# 2. LPG(液化石油氣-桶裝瓦斯)

# useTime
# 每日使用時間(分鐘)

# ngp
# 天然氣價格
# default is 21.7

# lpgp
# 液化石油氣價格
# default is 28.7


exports = module.exports =

    getData: ->
        _data = []
        # hT
        for i in [ 1, 2, 3]
            # aT
            for j in [ 1, 2]
                _data.push
                    hT: i
                    aT: j
                    useTime: 60
                    ngp: 21.7
                    lpgp: 28.7

        return _data

    rootURL: '/purchasing/compare/heater.asp'

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
