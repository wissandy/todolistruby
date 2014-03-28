require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(option={})
		option[:title] ||= "My todo list"
		option[:description] ||= "This is my todo list"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: option[:title]
		fill_in "Description", with: option[:description]
		click_button "Create Todo list"
	end

	it "redirect to the todo list index page on success" do

		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to_not have_content("This is what im doing today")
	end

	it "displays an error when the todo list has a title less than 3 characters" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what im doing today")
	end

	it "displays an error when the todo list has no description" do 

		expect(TodoList.count).to eq(0)

		create_todo_list title: "grocery list", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("grocery list")
	end

	it "displays an error when the todo list has no description" do 

		expect(TodoList.count).to eq(0)

		create_todo_list title: "grocery list", description: "food"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("grocery list")
	end
end