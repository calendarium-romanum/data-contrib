const calendarModule = process.argv[2]; // first commandline argument
const calendar = require(calendarModule);

const utils = require('romcal/dist/lib/Utils');
const _ = require('lodash');

const year = 1990; // any year would work

utils.setLocale('en');

// maps romcal ranks to calendarium-romanum rank codes
const rankMap = {
  'OPT_MEMORIAL': null,
  // we will be importing proper celebrations, hence the numbers
  'MEMORIAL': 'm3.11',
  'FEAST': 'f2.8',
  'SOLEMNITY': 's1.4',
};

const celebrationEntry = (celebration) => {
  const c = celebration;
  const rank = rankMap[c.type];
  const isColourRed =
        _.get(c, 'data.meta.liturgicalColor.key') == 'RED' ||
        _.get(c, 'data.titles', []).includes('MARTYR');

  console.log(
    (c.moment.month() + 1) + // momentjs has zero-based months
      '/' +
      c.moment.date() +
      ' ' +
      (null !== rank ? (rank + ' ') : '') +
      (isColourRed ? ('R ') : '') +
      c.key +
      ' : ' +
      c.name
  );
};

calendar
  .dates(year)
  .forEach(celebrationEntry);
