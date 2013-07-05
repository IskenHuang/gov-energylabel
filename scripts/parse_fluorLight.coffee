core = require('./core')

# form type:
#     S1:
#     S2:
# form url:
#     '/purchasing/compare/fluor_light.asp'

# S1
# 螢光燈管瓦數
# 1. 10W
# 2. >11~15W
# 3. >16~20W
# 4. >21~30W
# 5. =31W
# [1..5]

# S2
# 色溫範圍
# 1. 5700~7100K
# 2. 4600~5400K
# 3. 2600~4500K

exports = module.exports =

    getData: ->
        _data = []
        for i in [1..5]
            for j in [1..3]
                _data.push
                    S1: i
                    S2: j

        return _data

    rootURL: '/purchasing/compare/fluor_light.asp'

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
