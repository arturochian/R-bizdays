
context('handle specific calendars')

test_that('it should call bizdays.default with no default calendar', {
	bizdays.options$set(default.calendar=NULL)
	expect_error(bizdays('2013-07-12', '2014-07-12'))
})

test_that('it should use the default calendar', {
	cal <- Calendar(weekdays=c('saturday', 'sunday'))
	expect_true(cal$start.date == '1970-01-01')
	expect_true(cal$end.date == '2071-01-01')
	expect_true(all(cal$weekdays == c('saturday', 'sunday')))
	expect_equal(bizdays('2013-01-02', '2013-01-03', cal), 1)
	expect_equal(bizdays('2013-01-02', '2013-01-04', cal), 2)
	expect_equal(bizdays('2013-01-02', '2013-01-05', cal), 2)
	expect_equal(bizdays('2013-01-02', '2013-01-06', cal), 2)
	expect_equal(bizdays('2013-01-02', '2013-01-07', cal), 3)
	expect_error(bizdays('2013-01-02', '2090-01-07', cal), 'Given date out of range.')
	expect_error(bizdays('1700-01-02', '2013-01-07', cal), 'Given date out of range.')
})

test_that('it should create a short calendar and test its boundaries', {
	cal <- Calendar(start.date='2013-01-01', end.date='2013-12-31', weekdays=c('saturday', 'sunday'))
	expect_true(cal$start.date == '2013-01-01')
	expect_true(cal$end.date == '2013-12-31')
	expect_true(all(cal$weekdays == c('saturday', 'sunday')))
	expect_equal(bizdays('2013-01-02', '2013-01-03', cal), 1)
	expect_error(bizdays('2013-01-02', '2014-01-02', cal), 'Given date out of range.')
	expect_error(bizdays('2012-01-02', '2013-01-02', cal), 'Given date out of range.')
})

test_that('it should create an Actual Calendar', {
	cal <- Calendar(weekdays=NULL)
	expect_true(length(cal$weekdays) == 0)
	expect_true(cal$start.date == '1970-01-01')
	expect_true(cal$end.date == '2071-01-01')
	difference <- as.integer(as.Date('2013-02-03') - as.Date('2013-01-02'))
	expect_equal(bizdays('2013-01-02', '2013-02-03', cal), difference)
})

test_that('it should create a business Calendar: Brazil\'s ANBIMA', {
	data(holidaysANBIMA)
	cal <- Calendar(holidaysANBIMA, weekdays=c('saturday', 'sunday'))
	expect_equal(bizdays('2013-07-12', '2014-07-12', cal), 251)
	expect_equal(bizdays('2013-08-21', '2013-08-24', cal), 2)
	expect_equal(bizdays('2013-01-01', '2013-01-31', cal), 21)
	expect_equal(bizdays('2013-01-01', '2014-01-01', cal), 252)
	expect_equal(bizdays('2014-01-01', '2015-01-01', cal), 252)
	expect_equal(bizdays('2014-10-10', '2015-02-11', cal), 86)
	expect_equal(bizdays('2013-08-13', '2013-09-02', cal), 14)
	expect_equal(bizdays('2013-08-13', '2013-10-01', cal), 35)
	expect_equal(bizdays('2013-08-13', '2013-11-01', cal), 58)
	expect_equal(bizdays('2013-08-13', '2013-12-02', cal), 78)
	expect_equal(bizdays('2013-08-13', '2014-01-02', cal), 99)
	expect_equal(bizdays('2013-08-13', '2014-04-01', cal), 160)
	expect_equal(bizdays('2013-08-13', '2014-07-01', cal), 221)
	expect_equal(bizdays('2013-08-13', '2014-10-01', cal), 287)
	expect_equal(bizdays('2013-08-13', '2015-01-02', cal), 352)
	expect_equal(bizdays('2013-08-13', '2015-04-01', cal), 413)
	expect_equal(bizdays('2013-08-13', '2015-07-01', cal), 474)
	expect_equal(bizdays('2013-08-13', '2015-10-01', cal), 539)
	expect_equal(bizdays('2013-08-13', '2016-01-04', cal), 602)
	expect_equal(bizdays('2013-08-13', '2016-04-01', cal), 663)
	expect_equal(bizdays('2013-08-13', '2016-07-01', cal), 726)
	expect_equal(bizdays('2013-08-13', '2016-10-03', cal), 791)
	expect_equal(bizdays('2013-08-13', '2017-01-02', cal), 853)
	expect_equal(bizdays('2013-08-13', '2017-04-03', cal), 916)
	expect_equal(bizdays('2013-08-13', '2017-07-03', cal), 977)
	expect_equal(bizdays('2013-08-13', '2017-10-02', cal), 1041)
	expect_equal(bizdays('2013-08-13', '2018-01-02', cal), 1102)
	expect_equal(bizdays('2013-08-13', '2018-04-02', cal), 1163)
	expect_equal(bizdays('2013-08-13', '2018-07-02', cal), 1226)
	expect_equal(bizdays('2013-08-13', '2018-10-01', cal), 1290)
	expect_equal(bizdays('2013-08-13', '2019-01-02', cal), 1352)
	expect_equal(bizdays('2013-08-13', '2019-04-01', cal), 1413)
	expect_equal(bizdays('2013-08-13', '2019-07-01', cal), 1475)
	expect_equal(bizdays('2013-08-13', '2019-10-01', cal), 1541)
	expect_equal(bizdays('2013-08-13', '2020-01-02', cal), 1605)
	expect_equal(bizdays('2013-08-13', '2020-04-01', cal), 1667)
	expect_equal(bizdays('2013-08-13', '2020-07-01', cal), 1728)
	expect_equal(bizdays('2013-08-13', '2020-10-01', cal), 1793)
	expect_equal(bizdays('2013-08-13', '2021-01-04', cal), 1856)
	expect_equal(bizdays('2013-08-13', '2021-07-01', cal), 1979)
	expect_equal(bizdays('2013-08-13', '2022-01-03', cal), 2107)
	expect_equal(bizdays('2013-08-13', '2022-07-01', cal), 2231)
	expect_equal(bizdays('2013-08-13', '2023-01-02', cal), 2358)
	expect_equal(bizdays('2013-08-13', '2024-01-02', cal), 2607)
	expect_equal(bizdays('2013-08-13', '2025-01-02', cal), 2861)
})

context('check whether or not a date is a business day')

test_that("is business day", {
	data(holidaysANBIMA)
	cal <- Calendar(holidaysANBIMA, weekdays=c('saturday', 'sunday'))
	expect_false(is.bizday('2013-01-01', cal))
	expect_true(is.bizday('2013-01-02', cal))
	dates <- seq(as.Date('2013-01-01'), as.Date('2013-01-05'), by='day')
	expect_equal(is.bizday(dates, cal), c(FALSE, TRUE, TRUE, TRUE, FALSE))
})

context('adjustment of business days')

data(holidaysANBIMA)
cal <- Calendar(holidaysANBIMA, weekdays=c('saturday', 'sunday'))

test_that("it should move date to next business day", {
	date <- as.character(adjust.next('2013-01-01', cal))
	expect_equal(date, '2013-01-02')
})

test_that("it should move date to previous business day", {
	date <- as.character(adjust.previous('2013-02-02', cal))
	expect_equal(date, '2013-02-01')
})

test_that('it should adjust.next a vector of dates', {
    dates <- c(as.Date('2013-01-01'), as.Date('2013-01-02'))
    adj.dates <- adjust.next(dates, cal)
    expect_equal(adj.dates, c(as.Date('2013-01-02'), as.Date('2013-01-02')))
})

test_that('it should adjust.previous a vector of dates', {
    dates <- c(as.Date('2013-01-01'), as.Date('2013-01-02'))
    adj.dates <- adjust.previous(dates, cal)
    expect_equal(adj.dates, c(as.Date('2012-12-31'), as.Date('2013-01-02')))
})

context('sequence of bizdays')

test_that("it should generate a sequence of bizdays", {
    s <- c("2013-01-02","2013-01-03","2013-01-04","2013-01-07","2013-01-08",
    "2013-01-09","2013-01-10")
    expect_true(all( bizseq('2013-01-01', '2013-01-10', cal) == s ))
})

context('offset by a number of business days')

test_that("it should offset the date by n business days", {
	expect_equal(add.bizdays('2013-01-02', 1, cal), as.Date('2013-01-03'))
	expect_equal(add.bizdays('2013-01-02', 3, cal), as.Date('2013-01-07'))
	expect_equal(add.bizdays('2013-01-02', 0, cal), as.Date('2013-01-02'))
	expect_equal(add.bizdays('2013-01-01', 0, cal), as.Date('2013-01-02'))
	expect_equal(add.bizdays('2013-01-01', -1, cal), as.Date('2012-12-31'))
	expect_equal(offset('2013-01-02', 1, cal), as.Date('2013-01-03'))
	expect_equal(offset('2013-01-02', 3, cal), as.Date('2013-01-07'))
	expect_equal(offset('2013-01-02', 0, cal), as.Date('2013-01-02'))
	expect_equal(offset('2013-01-01', 0, cal), as.Date('2013-01-02'))
	expect_equal(offset('2013-01-01', -1, cal), as.Date('2012-12-31'))
	dates <- c(as.Date('2013-01-01'), as.Date('2013-01-02'))
	expect_equal(add.bizdays(dates, 1, cal), c(as.Date('2013-01-03'), as.Date('2013-01-03')))
	expect_equal(add.bizdays('2013-01-02', c(1, 3), cal), c(as.Date('2013-01-03'), as.Date('2013-01-07')))
	cal <- Calendar(start.date='2013-01-01', end.date='2013-01-31')
	expect_error(add.bizdays('2013-01-10', 30, cal))
})

test_that('it should warn for bad settings', {
	data(holidaysANBIMA)
	expect_warning(Calendar(holidaysANBIMA), 'You provided holidays without set weekdays.\nThat setup leads to inconsistencies!')
})