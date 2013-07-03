core = require('./core')
# parse air_conditioning.html

# form type:
#     T1:
#     S1:
#     S2:
# form url:
#     '/purchasing/compare/air_conditioning.asp'

# S1
# 水冷蒸發式(9)
# 氣冷式(10)

# S2
# 單體式(4)
# 分離式(5)

# T1
# 空間坪數
# 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100

exports = module.exports =
    data: [
        S1: 9,
        S2: ''
    ,
        S1: 10,
        S2: 4
    ,
        S1: 10,
        S2: 5
    ],

    rootURL: '/purchasing/compare/air_conditioning.asp'

    getData: ->
        _data = []
        i = 0
        while i < 100
            for item in @data
                _item = core.clone item
                _item['T1'] = i
                _data.push _item

            i += 5

        return _data

    parse: (options = { source: 'http' })->
        if options.source is 'file'
            for i in @data
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
