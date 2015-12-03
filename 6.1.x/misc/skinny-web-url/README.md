Skinny Web Url
==============

Skinny Web Url can be used to get a json of content from liferay. You can get all of the articles from a given structure in a form that is useful to parse through. The code in skinny_web_url.js is something you can past into a web content article and if you want to pull content form liferay cross browser.
[http://www.liferay.com/skinny-web/api/jsonws/skinny/get-skinny-journal-articles?inst=welcomeContent&companyId=1&groupName=Guest&journalStructureId=27308142&locale=en_US%22](http://www.liferay.com/skinny-web/api/jsonws/skinny/get-skinny-journal-articles?inst=welcomeContent&companyId=1&groupName=Guest&journalStructureId=27308142&locale=en_US%22)

On the site you could just use [this](http://www.liferay.com/skinny-web/api/jsonws/skinny/get-skinny-journal-articles?companyId=1&groupName=Guest&journalStructureId=27308142&locale=en_US%22) url and it will give you a json that you can loop through. All you need to change is the "journalStructureId" variable in the url to the structure id you want and it will give you all the articles.