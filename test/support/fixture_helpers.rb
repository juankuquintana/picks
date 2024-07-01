# frozen_string_literal: true

module FixtureHelpers

  def fixture(*names)
    Rails.root.join('test', 'fixtures', 'files', *names).to_s
  end

  def read_fixture(*names)
    File.read(fixture(*names))
  end

end
