require File.dirname(__FILE__) + '/../../spec_helper'

describe 'S3.delete_bucket' do

  before(:all) do
    s3.put_bucket('fogdeletebucket')
  end

  it 'should include fogdeletebucket in get_service before delete_bucket' do
    eventually do
      actual = s3.get_service
      actual.body[:buckets].collect { |bucket| bucket[:name] }.should include('fogdeletebucket')
    end
  end

  it 'should return proper attributes' do
    actual = s3.delete_bucket('fogdeletebucket')
    actual.status.should == 204
  end

  it 'should not include fogdeletebucket in get_service after delete_bucket' do
    eventually do
      actual = s3.get_service
      actual.body[:buckets].collect { |bucket| bucket[:name] }.should_not include('fogdeletebucket')
    end
  end

end
