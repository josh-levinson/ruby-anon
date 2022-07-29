system 'bundle exec ruby whitelist.rb'

require 'data-anonymization'

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'parvati_development' do
  strategy DataAnon::Strategy::Blacklist
  source_db adapter: 'postgres', database: 'parvati_development'

  table 'agreement_support_urls' do
    anonymize('url_data').using FieldStrategy::RandomString.new
  end

  table 'agreements' do
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
    anonymize('domain').using FieldStrategy::RandomString.new
  end

  table 'messages' do
    anonymize('sender').using FieldStrategy::RandomFullName.new
    anonymize('subject').using FieldStrategy::RandomString.new
    # TODO: Add to, cc, bcc array fields
    anonymize('body').using FieldStrategy::RandomString.new
  end

  table 'recipient_requests' do
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('email').using FieldStrategy::RandomEmail.new
  end

  table 'request_forms' do
    anonymize('name').using FieldStrategy::RandomString.new
    anonymize('description').using FieldStrategy::RandomString.new
    anonymize('instructions').using FieldStrategy::RandomString.new
  end

  table 'request_template_questions' do
    anonymize('description').using FieldStrategy::RandomString.new
  end

  table 'task_templates' do
    anonymize('text').using FieldStrategy::RandomString.new
    anonymize('name').using FieldStrategy::RandomString.new
  end

  table 'tasks' do
    anonymize('text').using FieldStrategy::RandomString.new
    anonymize('name').using FieldStrategy::RandomString.new
  end

  table 'templates' do
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
