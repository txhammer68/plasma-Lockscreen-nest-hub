const scrapeIt = require("scrape-it")
const { map } = require("lodash/fp")
const fs = require('fs')

// Constants
const url                  = "http://money.cnn.com/data/markets/"
const col                  = "div.column.double-column > div.column.left-column > "
const wm                   = "> a > span.world-market-"

// Selector Functions
const points               = i => name => "li:nth-child(" + i + ") span.ticker-" + name
const [dow, nasdaq, sp500] = map(points, [1,2,3])
const nth                  = i => "div:nth-child(" + i + ") "
const london               = i => col + nth(3) + "> div > " + nth(2) + "> " + nth(1) + wm + i
const hk                   = i => col + nth(3) + "> div > " + nth(1) + nth(2) + wm + i
const germany              = i => nth(3) + "> div > " + nth(2) + "> " + nth(2) + wm + i
const japan                = i => nth(1) + nth(1) + nth(1) + "span.world-market-" + i
const yield10              = i => col + nth(2) + "> ul > li:nth-child(1) > a > span.column.quote-" + i
const keyStats             = (n, i) => col + nth(2) + "> ul > li:nth-child(" + i + ") > a > span.column.quote-" + n


const selector = {
    dow            : dow      ('points'),
    dowChgPcnt     : dow      ('name-change'),
    dowChg         : dow      ('points-change'),
    nasdaq         : nasdaq   ('points'),
    nasdaqChgPcnt  : nasdaq   ('name-change'),
    nasdaqChg      : nasdaq   ('points-change'),
    sp500          : sp500    ('points'),
    sp500ChgPcnt   : sp500    ('name-change'),
    sp500Chg       : sp500    ('points-change'),
    japan          : japan    ('change-last'),
    japanChgPcnt   : japan    ('change-percent'),
    japanChg       : japan    ('change'),
    hk             : hk       ('change-last'),
    hkChgPcnt      : hk       ('change-percent'),
    hkChg          : hk       ('change'),
    london         : london   ('change-last'),
    londonChgPcnt  : london   ('change-percent'),
    londonChg      : london   ('change'),
    germany        : germany  ('change-last'),
    germanyChgPcnt : germany  ('change-percent'),
    germanyChg     : germany  ('change'),
    yield10Y       : keyStats ('col', 1),
    yield10YChg    : keyStats ('change', 1),
    oil            : keyStats ('col', 2),
    oilChg         : keyStats ('change', 2),
    gold           : keyStats ('col', 5),
    goldChg        : keyStats ('change', 5)
}

const cnnMarket = async () => {
    const d = (await (scrapeIt(url, selector))).data
   
   var dow1 = (d.dow + "  "+d.dowChg)
   var nasdaq1 = (d.nasdaq+"  "+d.nasdaqChg)
   var sp1 = (d.sp500+"  "+d.sp500Chg)
   var oil1 = (d.oil+"  "+d.oilChg)
   var gold1 = (d.gold+"  "+d.goldChg)
   var yield1 = (d.yield10Y + "  "+d.yield10YChg)
   
   let t1 = `var dow  = \x22`
                let t2 = dow1
                let t3 = `\nvar nasdaq  = \x22`
                let t4 = nasdaq1
                let t5 = `  |  \x22`
                let t6 = `\nvar sp500  = \x22`
                let t7 = sp1
                let t8 = `\nvar oil  = \x22`
                let t9 = oil1
                let t10 = `\nvar gold  = \x22`
                let t11 = gold1
                let t12 = `\x22`
                let t13 = `\nvar yield10  = \x22`
                let t14 = yield1
                
                
fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t1, function (err) {
  if (err) throw err;
});
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t2, function (err) {
  if (err) throw err;
});     
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t5, function (err) {
  if (err) throw err;
});    

    
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t3, function (err) {
  if (err) throw err;
});    
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t4, function (err) {
  if (err) throw err;
});
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t5,
                function (err) {
  if (err) throw err;
});
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t6, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t7, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t12, function (err) {
  if (err) throw err;
});    
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t8, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t9, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t5, function (err) {
  if (err) throw err;
});    
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t10, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t11, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t5, function (err) {
  if (err) throw err;
});    
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t13, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t14, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t12, function (err) {
  if (err) throw err;
});    
   
   
    return  [
        { symbol: "DOW",      value: d.dow,      change: d.dowChg,     changePcnt: d.dowChgPcnt      },
        { symbol: "NASDAQ",   value: d.nasdaq,   change: d.nasdaqChg,  changePcnt: d.nasdaqChgPcnt   },
        { symbol: "S&P500",   value: d.sp500,    change: d.sp500Chg,   changePcnt: d.sp500ChgPcnt    },
        { symbol: "Japan",    value: d.japan,    change: d.japanChg,   changePcnt: d.japanChgPcnt    },
        { symbol: "HongKong", value: d.hk,       change: d.hkChg,      changePcnt: d.hkChgPcnt       },
        { symbol: "London",   value: d.london,   change: d.londonChg,  changePcnt: d.londonChgPcnt   },
        { symbol: "Germany",  value: d.germany,  change: d.germanyChg, changePcnt: d.germanyChgPcnt  },
        { symbol: "Yield10y", value: d.yield10Y, change: d.yield10YChg                               },
        { symbol: "Oil",      value: d.oil,      change: d.oilChg                                    },
        { symbol: "Gold",     value: d.gold,     change: d.goldChg                                   },
    ]     
}


module.exports = {
    cnnMarket
}

