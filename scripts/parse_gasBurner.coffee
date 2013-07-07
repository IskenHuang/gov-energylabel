core = require('./core')

# form type:
#     btype:
#     number:
#     gas:
#     time:
#     ngp:
#     lpgp:
# form url:
#     '/purchasing/compare/GasBurner.asp'

# btype
# 裝置方式
# 64. 台面型
# 65. 嵌入式
# 63. 桌上型

# number
# 爐口數
# 1. 1口
# 2. 2口
# 3. 3口
# 4. 4口
# 5. 5口

# gas
# 燃氣別
# 1. NG(天然氣)
# 2. LPG(液態石油氣)

# time
# 每爐平均每日使用時間(分鐘)

# ngp
# 天然氣價格
# default is 21.7

# lpgp
# 液化石油氣價格
# default is 28.7

exports = module.exports =

    getData: ->
        _data = []
        # btype
        for i in [ 63, 64, 65]
            # number
            for j in [ 1, 2, 3, 4, 5]
                # gas
                for k in [ 1, 2]
                    _data.push
                        btype: i
                        number: j
                        gas: k
                        time: 60
                        ngp: 21.7
                        lpgp: 28.7

        return _data

    rootURL: '/purchasing/compare/GasBurner.asp'

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
