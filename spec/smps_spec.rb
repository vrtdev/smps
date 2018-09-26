# frozen_string_literal: true
require 'spec_helper'

RSpec.describe SmPs do
  it "::VERSION" do
    expect(described_class::VERSION).not_to be nil
  end

  context ".new" do
    subject { SmPs.new }
    it do
      is_expected.to be_a(SmPs)
    end
  end
end
