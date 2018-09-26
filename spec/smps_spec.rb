# frozen_string_literal: true
require 'spec_helper'
require 'smps'

RSpec.describe SmPs do
  it "::VERSION" do
    expect(described_class::VERSION).not_to be nil
  end

  context ".new" do
    it do
      expect(SmPs.new).to be_a(SmPs::Client)
    end
  end
end
