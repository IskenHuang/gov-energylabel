fs = require('fs')
request = require('request')
cheerio = require('cheerio')
iconv = require('iconv-lite')
url = require('url');

exports = module.exports =
    baseURL: 'http://www.energylabel.org.tw'

    targetURL: @baseURL+'purchasing/compare/list.asp'

    getHtml: (url, cb)->
        request
            url: url
            encoding: 'binary'
        ,(error, response)=>
            if not error and response.statusCode is 200
                _buf = iconv.encode( response.body, 'binary')
                _html = iconv.decode( _buf, 'big5')

                $ = cheerio.load(_html)

                tmpArray = url.split('/')
                fn = tmpArray[tmpArray.length-1].split('.')[0]

                @savefile(new Date().getTime()+'_'+fn, _html)

                cb($)
            else
                console.log 'error = ', error, ' | url = ', url

        return this

    getHtmlLinks: ( $, cb)->
        _array = []

        $('html a').each (index, item)->
            _url = $(item).attr('href')

            if _url.indexOf('/purchasing/compare') >= 0 and
                    _array.indexOf(_url) < 0 and
                    _array.indexOf('list.asp') < 0

                _array.push(_url)

        return _array

    getHtmlSelect: ($select)->
        _array = []

        $select.find('option').each (_index, _item)->
            obj =
                index: _index
                text: $(_item).text()
                value: $(_item).attr('value')

            _array.push(obj)

        return _array;

    getHtmlForm: (options = { url: '', body: {} }, cb)->
        options.headers =
            'content-type': 'application/x-www-form-urlencoded'

        options.method = 'POST'
        options.encoding = 'binary'

        _body = url.format
            query: options.body
        options.body = _body.substring(1, _body.length)

        request options, (error, response)=>
            if not error and response.statusCode is 200
                _buf = iconv.encode( response.body, 'binary')
                _html = iconv.decode( _buf, 'big5')
                $ = cheerio.load(_html)

                tmpArray = options.url.split('/')
                fn = tmpArray[tmpArray.length-1].split('.')[0]

                @savefile(new Date().getTime()+'_'+fn+'_'+_body, _html)
                cb($)

            else
                console.log 'error = ', error
                console.log 'options = ', options

    getFile: ( path, cb)->
        fs.readFile path, (err, data)->
            if err
                console.log 'err = ', err
            else
                cb(data)

    getFileHtml: ( path, cb)->
        fs.readFile path, (err, data)->
            if err
                console.log 'err = ', err
            else
                $ = cheerio.load(data)
                cb($)

    savefile: ( name, data)->
        path = './data/'+name+'.html'
        fs.writeFile path, data, (err)->
            if err
                console.log 'err = ', err
            else
                console.log 'saved file ', path

    savefileJSON: ( name, data)->
        path = './data/'+name+'.json'
        fs.writeFile path, JSON.stringify(data, null, 4), (err)->
            if err
                console.log 'err = ', err
            else
                console.log 'saved file ', path
