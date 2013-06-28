core = require('./core')
cheerio = require('cheerio')
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

    init: (options = { source: 'file' })->
        if source is 'file'
            for i in @data
                @getFileFromArray
                    path: options.path
                , (result)->
                    console.log 'result = ', result
        else
            for i in @data
                @getHTTPFromArray
                    url: core.baseURL + @rootURL
                    body: i
                , (result)->
                    console.log 'result = ', result


    getHTTPFromArray: ( options = { url: core.baseURL + @rootURL, body: '' }, cb)->
        core.getHtmlForm
            url: options.url
            body: options.body
        , ($)=>
            @getFormHtml $, (result)->
                cb(result)

    getFileFromArray: ( options = { path: './data/1371999790466_fan.html' }, cb)->
        core.getFileHtml options.path, ($)=>
            @getFormHtml $, (result)->
                cb(result)

    getFormHtml: ($, cb)->
        $('form').each (index, item)->
            if $(item).attr('action').indexOf('/purchasing/compare/fan.asp?') >= 0
                header = []
                result = []

                $(item).find('table').each (index, item)->
                    _index = index
                    tmp = {}

                    $(item).find('td').each ( index, item)->
                        if _index is 0
                            header.push $(item).text()
                        else
                            if index%header.length is 0 and index isnt 0
                                # append object to result array
                                result.push tmp
                                tmp = {}

                            # set header and value to object
                            h = header[index%header.length]
                            tmp[h] = $(item).text()

                    # save file
                    savefileJSON 'fan'

                    # callback
                    cb(result)
