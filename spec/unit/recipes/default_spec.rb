#
# Cookbook Name:: lfs_modder
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'lfs_modder::default' do

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(step_into: ['modder'])
      runner.node.set['modules']['load'] = Array['8021q']
      runner.node.set['modules']['remove'] = Array['ipmi_si']
      runner.converge(described_recipe)
    end

  context 'default' do
    it 'loades 8021q' do
      expect(chef_run).to load_module('8021q')
    end

    it 'removes module ipmi_si' do
      expect(chef_run).to remove_module('ipmi_si')
    end

  end

end
