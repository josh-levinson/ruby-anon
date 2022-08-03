# frozen_string_literal: true

require 'data-anonymization'
require 'pg'

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'parvati_development' do
  strategy DataAnon::Strategy::Blacklist
  source_db adapter: 'postgresql',
            host: ENV['DATABASE_HOST'] || 'db',
            database: ENV['DATABASE_NAME'] || 'parvati_development',
            username: ENV['DATABASE_USER'] || 'postgres',
            password: ENV['DATABASE_PASSWORD'] || 'postgres',
            port: ENV['DATABASE_PORT'] || 5432,
            pool: 5,
            timeout: 5000

  table 'agreement_support_urls' do
    anonymize('url_data').using FieldStrategy::RandomString.new
  end

  table 'agreements' do
    primary_key 'id'
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('description').using FieldStrategy::RandomString.new
    anonymize('instructions').using FieldStrategy::RandomString.new
    anonymize('request_form_name').using FieldStrategy::RandomString.new
    anonymize('template_name').using FieldStrategy::RandomString.new
    anonymize('template_description').using FieldStrategy::RandomString.new
  end

  table 'companies' do
    primary_key 'id'
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('domain').using FieldStrategy::RandomString.new
  end

  table 'company_allowlist_emails' do
    primary_key 'id'
    anonymize('domain').using FieldStrategy::RandomString.new
  end

  table 'messages' do
    primary_key 'id'
    anonymize('sender').using FieldStrategy::RandomFullName.new
    anonymize('subject').using FieldStrategy::RandomString.new
    # TODO: Add to, cc, bcc array fields
    anonymize('body').using FieldStrategy::RandomString.new
  end

  table 'recipient_requests' do
    primary_key 'id'
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('email').using FieldStrategy::RandomEmail.new
  end

  table 'request_forms' do
    primary_key 'id'
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('description').using FieldStrategy::RandomString.new
    anonymize('instructions').using FieldStrategy::RandomString.new
  end

  table 'request_template_questions' do
    primary_key 'id'
    anonymize('description').using FieldStrategy::RandomString.new
  end

  table 'task_templates' do
    primary_key 'id'
    anonymize('text').using FieldStrategy::RandomString.new
    anonymize('name').using FieldStrategy::RandomString.new
  end

  table 'tasks' do
    primary_key 'id'
    anonymize('text').using FieldStrategy::RandomString.new
    anonymize('name').using FieldStrategy::RandomString.new
  end

  table 'templates' do
    primary_key 'id'
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('description').using FieldStrategy::RandomString.new
  end

  table 'users' do
    primary_key 'id'
    anonymize('first_name').using FieldStrategy::RandomFirstName.new
    anonymize('last_name').using FieldStrategy::RandomLastName.new
    anonymize('email').using FieldStrategy::RandomEmail.new
  end
end
