defmodule Top52Web.Router do
  use Top52Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Top52Web do
    pipe_through :api
    
    resources "/notes", NoteController, except: [:new, :edit]
  end

  scope "/top5", Top52Web do
    pipe_through :browser

    get     "/",                HomeController,     :index
    post    "/",                HomeController,     :sign_in
    get     "/register",        RegisterController, :index
    post    "/register",        RegisterController, :create
    get     "/tasks",           TaskController,     :index
    get     "/tasks/logout",    TaskController,     :logout
    get     "/tasks/create",    TaskController,     :show_create_task
    get     "/tasks/edit/:id",  TaskController,     :show_edit_task
    post    "/tasks/edit/:id",  TaskController,     :update_task
    post    "/tasks",           TaskController,     :create_task
  end

end