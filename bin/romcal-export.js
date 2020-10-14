const calendarModule = process.argv[2]; // first commandline argument
const calendar = require(calendarModule);

const utils = require('romcal/dist/lib/Utils');
const _ = require('lodash');
const yaml = require('js-yaml');

const year = 1990; // any year would work

const locale = 'en';
utils.setLocale(locale);

const calendarName = _.last(calendarModule.split('/')).replace('.js', '');
const isGeneralCalendar = calendarName === 'general';

// maps romcal ranks to calendarium-romanum rank codes
const rankMapProper = {
  'OPT_MEMORIAL': null,
  // we will be importing proper celebrations, hence the numbers
  'MEMORIAL': 'm3.11',
  'FEAST': 'f2.8',
  'SOLEMNITY': 's1.4',
};
const rankMapGeneral = {
  'OPT_MEMORIAL': null,
  'MEMORIAL': 'm',
  'FEAST': 'f',
  'SOLEMNITY': 's',
};
const rankMap = isGeneralCalendar ? rankMapGeneral : rankMapProper;

const monthHeading = momentjsMonth =>
      '= ' + (parseInt(momentjsMonth) + 1); // momentjs has zero-based months

const celebrationEntry = (celebration) => {
  const c = celebration;
  const rank = rankMap[c.type];
  const isColourRed =
        _.get(c, 'data.meta.liturgicalColor.key') == 'RED' ||
        _.get(c, 'data.titles', []).includes('MARTYR');

  console.log(
    // (c.moment.month() + 1) + '/' + // momentjs has zero-based months
    c.moment.date()
      + ' '
      + (null !== rank ? (rank + ' ') : '')
      + (isColourRed ? ('R ') : '')
      + c.key
      + ' : '
      + c.name
  );
};

const camelCaseToWords = str => {
  return _.upperFirst(
    str.replace(/([A-Z])/g, match => ' ' + match)
  );
};

const yamlFrontMatter = () => {
  let frontMatter = {
    title: camelCaseToWords(calendarName),
    locale: locale
  };
  if (!isGeneralCalendar) {
    frontMatter['parent'] = 'general.txt';
  }

  const yfmDelimiter = '---'

  return yfmDelimiter
    + "\n"
    + yaml.safeDump(frontMatter)
    + yfmDelimiter;
};

console.log(yamlFrontMatter());
byMonth = _.groupBy(calendar.dates(year), i => i.moment.month());
for (let month in byMonth) {
  console.log();
  console.log(monthHeading(month));
  byMonth[month].forEach(celebrationEntry);
}
