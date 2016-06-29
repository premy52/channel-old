require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ManagersController do

  # This should return the minimal set of attributes required to create a valid
  # Manager. As you add validations to Manager, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "first_name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ManagersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all managers as @managers" do
      manager = Manager.create! valid_attributes
      get :index, {}, valid_session
      assigns(:managers).should eq([manager])
    end
  end

  describe "GET show" do
    it "assigns the requested manager as @manager" do
      manager = Manager.create! valid_attributes
      get :show, {:id => manager.to_param}, valid_session
      assigns(:manager).should eq(manager)
    end
  end

  describe "GET new" do
    it "assigns a new manager as @manager" do
      get :new, {}, valid_session
      assigns(:manager).should be_a_new(Manager)
    end
  end

  describe "GET edit" do
    it "assigns the requested manager as @manager" do
      manager = Manager.create! valid_attributes
      get :edit, {:id => manager.to_param}, valid_session
      assigns(:manager).should eq(manager)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Manager" do
        expect {
          post :create, {:manager => valid_attributes}, valid_session
        }.to change(Manager, :count).by(1)
      end

      it "assigns a newly created manager as @manager" do
        post :create, {:manager => valid_attributes}, valid_session
        assigns(:manager).should be_a(Manager)
        assigns(:manager).should be_persisted
      end

      it "redirects to the created manager" do
        post :create, {:manager => valid_attributes}, valid_session
        response.should redirect_to(Manager.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved manager as @manager" do
        # Trigger the behavior that occurs when invalid params are submitted
        Manager.any_instance.stub(:save).and_return(false)
        post :create, {:manager => { "first_name" => "invalid value" }}, valid_session
        assigns(:manager).should be_a_new(Manager)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Manager.any_instance.stub(:save).and_return(false)
        post :create, {:manager => { "first_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested manager" do
        manager = Manager.create! valid_attributes
        # Assuming there are no other managers in the database, this
        # specifies that the Manager created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Manager.any_instance.should_receive(:update).with({ "first_name" => "MyString" })
        put :update, {:id => manager.to_param, :manager => { "first_name" => "MyString" }}, valid_session
      end

      it "assigns the requested manager as @manager" do
        manager = Manager.create! valid_attributes
        put :update, {:id => manager.to_param, :manager => valid_attributes}, valid_session
        assigns(:manager).should eq(manager)
      end

      it "redirects to the manager" do
        manager = Manager.create! valid_attributes
        put :update, {:id => manager.to_param, :manager => valid_attributes}, valid_session
        response.should redirect_to(manager)
      end
    end

    describe "with invalid params" do
      it "assigns the manager as @manager" do
        manager = Manager.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Manager.any_instance.stub(:save).and_return(false)
        put :update, {:id => manager.to_param, :manager => { "first_name" => "invalid value" }}, valid_session
        assigns(:manager).should eq(manager)
      end

      it "re-renders the 'edit' template" do
        manager = Manager.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Manager.any_instance.stub(:save).and_return(false)
        put :update, {:id => manager.to_param, :manager => { "first_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested manager" do
      manager = Manager.create! valid_attributes
      expect {
        delete :destroy, {:id => manager.to_param}, valid_session
      }.to change(Manager, :count).by(-1)
    end

    it "redirects to the managers list" do
      manager = Manager.create! valid_attributes
      delete :destroy, {:id => manager.to_param}, valid_session
      response.should redirect_to(managers_url)
    end
  end

end
