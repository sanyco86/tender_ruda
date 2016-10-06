require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(manager) }

  describe 'admin' do
    let(:manager) { create :manager, :admin }

    it { should be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    it { should be_able_to :new, :all }
    it { should be_able_to :create, :all }
    it { should be_able_to :edit, :all }
    it { should be_able_to :update, :all }
    it { should be_able_to :destroy, :all }
  end

  describe 'write' do
    let(:manager) { create :manager, :write }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    it { should be_able_to :new, :all }
    it { should be_able_to :create, :all }
    it { should be_able_to :edit, :all }
    it { should be_able_to :update, :all }
    it { should be_able_to :destroy, :all }
  end

  describe 'read' do
    let(:manager) { create :manager }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    it { should_not be_able_to :new, :all }
    it { should_not be_able_to :create, :all }
    it { should_not be_able_to :edit, :all }
    it { should_not be_able_to :update, :all }
    it { should_not be_able_to :destroy, :all }
  end
end
