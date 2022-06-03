# frozen_string_literal: true

def project_path
  File.expand_path('..', __dir__)
end

def fixture(fixture_name, format = 'xml')
  File.binread(project_path + "/spec/fixtures/#{fixture_name}.#{format}")
end
