core = require('./core')

# form type:
#     yMileage:
#     Exhaust:
#     oilp:
# form url:
#     '/purchasing/compare/Motorcycles.asp'

# yMileage
# 年行駛公里數(km)

# Exhaust
# 排氣量(cc)
# 1. <=50cc
# 2. >50cc且<=100cc
# 3. >100cc且<=150cc
# 4. >150

# oilp
# 油價
# default is 26.7

exports = module.exports =

    getData: ->
        _data = []
        # Exhaust
        for i in [1..4]
            _data.push
                yMileage: 1000
                Exhaust: i
                oilp: 26.7

        return _data

    rootURL: '/purchasing/compare/Motorcycles.asp'

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
