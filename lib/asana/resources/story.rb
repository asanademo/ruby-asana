### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _story_ represents an activity associated with an object in the Asana
    # system. Stories are generated by the system whenever users take actions such
    # as creating or assigning tasks, or moving tasks between projects. _Comments_
    # are also a form of user-generated story.
    #
    # Stories are a form of history in the system, and as such they are read-only.
    # Once generated, it is not possible to modify a story.
    class Stories < Resource


      attr_reader :id

      attr_reader :created_at

      attr_reader :created_by

      attr_reader :hearted

      attr_reader :hearts

      attr_reader :num_hearts

      attr_reader :text

      attr_reader :html_text

      attr_reader :target

      attr_reader :source

      attr_reader :type

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'stories'
        end

        # Returns the compact records for all stories on the task.
        #
        # task - [Id] Globally unique identifier for the task.
        #
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_task(client, task: required("task"), per_page: 20, options: {})
          params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/tasks/#{task}/stories", params: params, options: options)), type: self, client: client)
        end

        # Returns the full record for a single story.
        #
        # id - [Id] Globally unique identifier for the story.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/stories/#{id}", options: options)).first, client: client)
        end

        # Adds a comment to a task. The comment will be authored by the
        # currently authenticated user, and timestamped when the server receives
        # the request.
        #
        # Returns the full record for the new story added to the task.
        #
        # task - [Id] Globally unique identifier for the task.
        #
        # text - [String] The plain text of the comment to add.
        # options - [Hash] the request I/O options.
        # data - [Hash] the attributes to post.
        def create_on_task(client, task: required("task"), text: required("text"), options: {}, **data)
          with_params = data.merge(text: text).reject { |_,v| v.nil? || Array(v).empty? }
          self.new(parse(client.post("/tasks/#{task}/stories", body: with_params, options: options)).first, client: client)
        end
      end

    end
  end
end