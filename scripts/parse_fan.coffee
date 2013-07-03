core = require('./core')
# parse FAN.html

# form type:
#     S1:
#     subtype:
#     sizecode:
# form url:
#     '/purchasing/compare/fan.asp'

# 吊電扇規格(56)
# 60, 90, 120, 130, 140, 150

# 立地電扇規格(55)
# 30, 35, 40, 50, 60

# 桌上電扇規格(57)
# 18, 20, 23, 25, 30, 35, 40

# 自動旋選吊電扇(54)
# 30, 40

exports = module.exports =
    data: [
        S1: 56
        subtype: 60
        sizecode: 60
    ,
        S1: 56
        subtype: 90
        sizecode: 90
    ,
        S1: 56
        subtype: 120
        sizecode: 120
    ,
        S1: 56
        subtype: 130
        sizecode: 130
    ,
        S1: 56
        subtype: 140
        sizecode: 140
    ,
        S1: 56
        subtype: 150
        sizecode: 150
    ,
        S1: 55
        subtype: 30
        sizecode: 30
    ,
        S1: 55
        subtype: 35
        sizecode: 35
    ,
        S1: 55
        subtype: 40
        sizecode: 40
    ,
        S1: 55
        subtype: 50
        sizecode: 50
    ,
        S1: 55
        subtype: 60
        sizecode: 60
    ,
        S1: 57
        subtype: 18
        sizecode: 18
    ,
        S1: 57
        subtype: 20
        sizecode: 20
    ,
        S1: 57
        subtype: 23
        sizecode: 23
    ,
        S1: 57
        subtype: 25
        sizecode: 25
    ,
        S1: 57
        subtype: 30
        sizecode: 30
    ,
        S1: 57
        subtype: 35
        sizecode: 35
    ,
        S1: 57
        subtype: 40
        sizecode: 40
    ,
        S1: 54
        subtype: 30
        sizecode: 30
    ,
        S1: 54
        subtype: 40
        sizecode: 40
    ],

    rootURL: '/purchasing/compare/fan.asp'

    parse: (options = { source: 'http' })->
        if options.source is 'file'
            for i in @data
                core.getFileFromArray
                    path: options.path
                , (result)->
                    console.log 'result = ', result
        else
            for i in @data
                core.getHTTPFromArray
                    url: @rootURL
                    body: i
                , (result)->
                    console.log 'result = ', result