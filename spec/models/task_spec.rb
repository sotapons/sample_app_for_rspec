require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
  #全ての属性が適切であれば有効
  it "is valid with all attributes" do
    task = build(:task)
    expect(task).to be_valid
    expect(task.errors).to be_empty
  end

  #タイトルがなければ無効
  it "is invalid without title" do
    task_without_title = build(:task, title: "")
    expect(task_without_title).to be_invalid
    expect(task_without_title.errors[:title]).to eq ["can't be blank"]
  end

  #ステータスがなければ無効
  it "is invalid without status" do
    task_without_status = build(:task, status: nil)
    expect(task_without_status).to be_invalid
    expect(task_without_status.errors[:status]).to eq ["can't be blank"]
  end

  #タイトルが重複していれば無効
  it "is invalid with a duplicate title" do
    task = create(:task)
    task_with_duplicated_title = build(:task, title: task.title)
    expect(task_with_duplicated_title).to be_invalid
    expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
  end

  #タイトルが別名であれば有効
  it "is valid with another title" do
    task = create(:task)
    task_without_another_title = build(:task, title: "another_title")
    expect(task_without_another_title).to be_valid
    expect(task_without_another_title.errors).to be_empty
  end
 end
end
