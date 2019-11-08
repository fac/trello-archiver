class FakeTrelloApi
  def initialize(card_activity=nil, config)
    @card_activity = card_activity
    @config = config
    if @card_activity.nil?
      @card_activity = FakeTrelloApi.card_activity_created_in_progress(config)
    end
  end

  def fetch_member(member_id)
    "Colin Gemmell"
  end

  def self.debug_card(config)
    JSON.parse('[{"id":"5cb05e9d294fa648daf4091a","idMemberCreator":"5abe0419bd770fe51d9bd476","data":{"listAfter":{"name":"Celebrate 🎉","id":"5badecf999b0e03dd92a033b"},"listBefore":{"name":"In Review + PPT","id":"5c864dc9bc0294262d46d3f4"},"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55","idList":"5badecf999b0e03dd92a033b"},"old":{"idList":"5c864dc9bc0294262d46d3f4"}},"type":"updateCard","date":"2019-04-12T09:47:09.284Z","limits":{},"memberCreator":{"id":"5abe0419bd770fe51d9bd476","avatarHash":"3c7f0f95d4d64a8106ea958fc8aadc30","avatarUrl":"https://trello-avatars.s3.amazonaws.com/3c7f0f95d4d64a8106ea958fc8aadc30","fullName":"Colin Gemmell","idMemberReferrer":null,"initials":"CG","nonPublic":{},"nonPublicAvailable":false,"username":"colingemmell1"}},{"id":"5cb04ef37361e062d389b912","idMemberCreator":"5abe0419bd770fe51d9bd476","data":{"list":{"name":"In Review + PPT","id":"5c864dc9bc0294262d46d3f4"},"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55","pos":4833280},"old":{"pos":4390912}},"type":"updateCard","date":"2019-04-12T08:40:19.313Z","limits":{},"memberCreator":{"id":"5abe0419bd770fe51d9bd476","avatarHash":"3c7f0f95d4d64a8106ea958fc8aadc30","avatarUrl":"https://trello-avatars.s3.amazonaws.com/3c7f0f95d4d64a8106ea958fc8aadc30","fullName":"Colin Gemmell","idMemberReferrer":null,"initials":"CG","nonPublic":{},"nonPublicAvailable":false,"username":"colingemmell1"}},{"id":"5cb04ef37361e062d389b911","idMemberCreator":"5abe0419bd770fe51d9bd476","data":{"listAfter":{"name":"In Review + PPT","id":"5c864dc9bc0294262d46d3f4"},"listBefore":{"name":"Blocked","id":config.blocked_column_id},"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55","idList":"5c864dc9bc0294262d46d3f4"},"old":{"idList":config.blocked_column_id}},"type":"updateCard","date":"2019-04-12T08:40:19.291Z","limits":{},"memberCreator":{"id":"5abe0419bd770fe51d9bd476","avatarHash":"3c7f0f95d4d64a8106ea958fc8aadc30","avatarUrl":"https://trello-avatars.s3.amazonaws.com/3c7f0f95d4d64a8106ea958fc8aadc30","fullName":"Colin Gemmell","idMemberReferrer":null,"initials":"CG","nonPublic":{},"nonPublicAvailable":false,"username":"colingemmell1"}},{"id":"5ca4cd29d94bd628e636131a","idMemberCreator":"57728df5519ae6675336d075","data":{"list":{"name":"Blocked","id":config.blocked_column_id},"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55","pos":4390912},"old":{"pos":4767744}},"type":"updateCard","date":"2019-04-03T15:11:37.715Z","limits":{},"memberCreator":{"id":"57728df5519ae6675336d075","avatarHash":"f2b032357b388efe8b3021c483f0e723","avatarUrl":"https://trello-avatars.s3.amazonaws.com/f2b032357b388efe8b3021c483f0e723","fullName":"Peter Singh","idMemberReferrer":null,"initials":"PS","nonPublic":{},"nonPublicAvailable":false,"username":"petersingh3"}},{"id":"5ca4cd29d94bd628e6361319","idMemberCreator":"57728df5519ae6675336d075","data":{"listAfter":{"name":"Blocked","id":config.blocked_column_id},"listBefore":{"name":"In Progress","id":config.started_column_id},"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55","idList":config.blocked_column_id},"old":{"idList":config.started_column_id}},"type":"updateCard","date":"2019-04-03T15:11:37.689Z","limits":{},"memberCreator":{"id":"57728df5519ae6675336d075","avatarHash":"f2b032357b388efe8b3021c483f0e723","avatarUrl":"https://trello-avatars.s3.amazonaws.com/f2b032357b388efe8b3021c483f0e723","fullName":"Peter Singh","idMemberReferrer":null,"initials":"PS","nonPublic":{},"nonPublicAvailable":false,"username":"petersingh3"}},{"id":"5ca4cd234b0b4e323f73dd56","idMemberCreator":"57728df5519ae6675336d075","data":{"board":{"shortLink":"nJxdin1P","name":"Workflow Sprint Board","id":"5bade24c8194ba1e9b88bbe6"},"list":{"name":"In Progress","id":config.started_column_id},"card":{"shortLink":"4w0eofM1","idShort":291,"name":"Refactor Bills Javascript","id":"5ca4cd234b0b4e323f73dd55"}},"type":"createCard","date":"2019-04-03T15:11:31.286Z","limits":{},"memberCreator":{"id":"57728df5519ae6675336d075","avatarHash":"f2b032357b388efe8b3021c483f0e723","avatarUrl":"https://trello-avatars.s3.amazonaws.com/f2b032357b388efe8b3021c483f0e723","fullName":"Peter Singh","idMemberReferrer":null,"initials":"PS","nonPublic":{},"nonPublicAvailable":false,"username":"petersingh3"}}]')
  end

  def self.card_activity_blocked_single(config)
		[
			 {
					"data" => {
						 "listAfter" => {
								"name" => "Celebrate 🎉",
                "id" => config.list_id
						 },
						 "listBefore" => {
								"name" => "In Review + PPT",
								"id" => "5c864dc9bc0294262d46d3f4"
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-12T09:47:09.284Z",
			 },
			 {
					"data" => {},
					"type" => "updateCard",
					"date" => "2019-04-12T08:40:19.313Z",
			 },
			 {
					"data" => {
						 "listAfter" => {
								"name" => "In Review + PPT",
								"id" => "5c864dc9bc0294262d46d3f4"
						 },
						 "listBefore" => {
								"name" => "Blocked",
								"id" => config.blocked_column_id
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-12T08:40:19.291Z",
			 },
			 {
					"data" => {},
					"type" => "updateCard",
					"date" => "2019-04-03T15:11:37.715Z",
			 },
			 {
					"data" => {
						 "listAfter" => {
								"name" => "Blocked",
								"id" => config.blocked_column_id
						 },
						 "listBefore" => {
								"name" => "In Progress",
								"id" => config.started_column_id
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-03T15:11:37.689Z",
			 },
			 {
					"data" => {},
					"type" => "createCard",
					"date" => "2019-04-03T15:11:31.286Z",
			 }
		]
  end

  def self.card_activity_blocked_multiple(config)
		[
			 {
					"data" => {
						 "listAfter" => {
								"name" => "Celebrate 🎉",
                "id" => config.list_id
						 },
						 "listBefore" => {
								"name" => "Blocked",
                "id" => config.blocked_column_id
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-14T09:47:09.284Z",
			 },
			 {
					"data" => {
						 "listAfter" => {
								"name" => "Blocked",
								"id" => config.blocked_column_id
						 },
						 "listBefore" => {
								"name" => "In Review + PPT",
								"id" => "5c864dc9bc0294262d46d3f4"
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-12T15:11:37.689Z",
			 },
			 {
					"data" => {},
					"type" => "updateCard",
					"date" => "2019-04-12T08:40:19.313Z",
			 },
			 {
					"data" => {
						 "listAfter" => {
								"name" => "In Review + PPT",
								"id" => "5c864dc9bc0294262d46d3f4"
						 },
						 "listBefore" => {
								"name" => "Blocked",
								"id" => config.blocked_column_id
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-12T08:40:19.291Z",
			 },
			 {
					"data" => {},
					"type" => "updateCard",
					"date" => "2019-04-03T15:11:37.715Z",
			 },
			 {
					"data" => {
						 "listAfter" => {
								"name" => "Blocked",
								"id" => config.blocked_column_id
						 },
						 "listBefore" => {
								"name" => "In Progress",
								"id" => config.started_column_id
						 },
					},
					"type" => "updateCard",
					"date" => "2019-04-03T15:11:37.689Z",
			 },
			 {
					"data" => {},
					"type" => "createCard",
					"date" => "2019-04-03T15:11:31.286Z",
			 }
		]
  end

  def self.card_activity_created_in_progress(config)
    [
      {
        "data" => {
          "listAfter" => {
            "name" => "Celebrate 🎉",
            "id" => config.list_id
          },
          "listBefore" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-26T14:24:54.500Z",
      },
      {
        "data" => {
          "list" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-22T10:00:40.466Z",
      },
      {
        "data" => {
          "list" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
        },
        "type" => "createCard",
        "date" => "2019-02-21T10:00:12.682Z",
      }
    ]
  end

  def self.card_activity_created_in_planned(config)
    [
      {
        "data" => {
          "listAfter" => {
            "name" => "Celebrate 🎉",
            "id" => config.list_id
          },
          "listBefore" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-26T14:24:54.500Z",
      },
      {
        "data" => {
          "listAfter" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
          "listBefore" => {
            "name" => "Planned",
            "id" => "planned_id"
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-23T10:00:40.466Z",
      },
      {
        "data" => {
          "list" => {
            "name" => "Planned",
            "id" => "planned_id"
          },
        },
        "type" => "createCard",
        "date" => "2019-02-21T10:00:12.682Z",
      }
    ]
  end

  def self.card_started_and_finished_on_same_day(config)
    [
      {
        "data" => {
          "listAfter" => {
            "name" => "Celebrate 🎉",
            "id" => config.list_id
          },
          "listBefore" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-26T14:24:54.500Z",
      },
      {
        "data" => {
          "listAfter" => {
            "name" => "In Progress",
            "id" => config.started_column_id
          },
          "listBefore" => {
            "name" => "Planned",
            "id" => "planned_id"
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-26T14:24:54.500Z",
      },
      {
        "data" => {
          "list" => {
            "name" => "Planned",
            "id" => "planned_id"
          },
        },
        "type" => "createCard",
        "date" => "2019-02-21T10:00:12.682Z",
      }
    ]
  end

  def self.card_activity_created_in_celebrate(config)
    [
      {
        "data" => {
          "list" => {
            "name" => "Celebrate 🎉",
            "id" => config.list_id
          },
        },
        "type" => "createCard",
        "date" => "2019-02-21T10:00:12.682Z",
      }
    ]
  end

  def self.card_activity_was_never_in_progress(config)
    [
      {
        "data" => {
          "listAfter" => {
            "name" => "Celebrate 🎉",
            "id" => config.list_id
          },
          "listBefore" => {
            "name" => "Maintanice",
            "id" => "maintainceId"
          },
        },
        "type" => "updateCard",
        "date" => "2019-02-26T14:24:54.500Z",
      },
      {
        "data" => {
          "list" => {
            "name" => "Maintaince",
            "id" => "maintainceId"
          },
        },
        "type" => "createCard",
        "date" => "2019-02-21T10:00:12.682Z",
      }
    ]
  end

  def card_activity(card_short_link)
    @card_activity
  end

  def cards
    [
      {
        "dateLastActivity"=>"2019-03-04T12:38:19.254Z",
        "name"=>"Stripe auto-reconciliation investigation",
        "shortLink"=>"F3Sj1lcw",
        "idMembers"=>["5abe0419bd770fe51d9bd476"],
        "labels"=> [
          {
            "id"=>"5c73dfef88a0747376e384cd",
            "idBoard"=>"5bade24c8194ba1e9b88bbe6",
            "name"=>"Investigation",
            "color"=>"black"
          }
        ],
        "shortLink"=>"F3Sj1lcw",
        "shortUrl"=>"https://trello.com/c/F3Sj1lcw",
        "url"=>"https://trello.com/c/F3Sj1lcw/239-stripe-auto-reconciliation-investigation"
      },
      {
        "dateLastActivity"=>"2019-10-31T12:19:34.376Z",
        "name"=>"[1d] send_new_invoice_emails Recurring Invoice sync issue",
        "shortLink"=>"Ks018zJG",
        "idMembers"=> ["5abe0419bd770fe51d9bd476", "5d9b05bc19093439cd980ba3"],
        "labels"=> [
          {
            "id"=>"5c053846c1c0050bb90329a6",
            "idBoard"=>"5bade24c8194ba1e9b88bbe6",
            "name"=>"Unplanned",
            "color"=>"blue"
          }
        ],
        "shortUrl"=>"https://trello.com/c/Ks018zJG",
        "subscribed"=>true,
        "url"=>"https://trello.com/c/Ks018zJG/642-1d-sendnewinvoiceemails-recurring-invoice-sync-issue"
      }
    ].map{|card| Trello::Card.new(card, self, @config) }
  end
end
