Email.create!(template: "newsfeed",
							subject: "Newsfeed Template",
							body: "<p>This is the newsfeed template</p>",
							default_template: true)

Email.create!(template: "subs reminder",
							subject: "Subs Reminder Template",
							body: "<p>This is the subs reminder template</p>",
							default_template: true)

Email.create!(member_id: 3,
							template: "welcome",
							subject: "Welcome to the Leeds Mountaineering Club",
							body: "<p>This is the welcome email</p>",
							default_template: true)