core = require('./core')

# form type:
#     cartype:
#     mile:
#     CC:
#     oilp:
# form url:
#     '/purchasing/compare/minibus.asp'

# cartype
# 車種
# 58. 小客車(轎式)
# 80. 小客車(旅行式)
# 81. 小客車(非轎式.非旅行式)
# 82. 小貨車
# 83. 小客貨兩用車

# mile
# 年行駛公里數(km)

# CC
# 排氣量(cc)
# 1. 小於或等於1200cc
# 2. 大於1200cc且小於等於1800cc
# 3. 大於1800cc

# oilp
# 油價
# default is 26.7



exports = module.exports =

    getData: ->
        _data = []
        # cartype
        for i in [ 58, 80, 81, 82, 83]
            # CC
            for j in [ 1, 2, 3]
                _data.push
                    cartype: i
                    mile: 1000
                    CC: j
                    oilp: 26.7

        return _data

    rootURL: '/purchasing/compare/minibus.asp'

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
