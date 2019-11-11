# cnn-market
Stock market information from CNN

# Usage

```js
const { cnnMarket } = require("cnn-market")

cnnMarket().then( data => console.log(data) )
```
Example Output:
```
[ { symbol: 'DOW',
    value: '25,886.01',
    change: '+306.62',
    changePcnt: '+1.20%' },
  { symbol: 'NASDAQ',
    value: '7,895.99',
    change: '+129.38',
    changePcnt: '+129.38' },
  { symbol: 'S&P500',
    value: '2,888.68',
    change: '+41.08',
    changePcnt: '+1.44%' },
  { symbol: 'Japan',
    value: '20,418.81',
    change: '+13.17',
    changePcnt: '+0.06%' },
  { symbol: 'HongKong',
    value: '25,734.22',
    change: '+241.00',
    changePcnt: '+0.94%' },
  { symbol: 'London',
    value: '7,117.15',
    change: '+50.50',
    changePcnt: '+0.71%' },
  { symbol: 'Germany',
    value: '11,562.74',
    change: '+152.04',
    changePcnt: '+1.31%' },
  { symbol: 'Yield10y',
    value: '1.54%',
    change: '+0.01' },
  { symbol: 'Oil',
    value: '$54.94',
    change: '+0.13' },
  { symbol: 'Gold',
    value: '$1,523.60',
    change: '0.00' } ]
```
