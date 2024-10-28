class StudentsController < ApplicationController
  def index
     @students = current_teacher.students
  end


  def new
    @student = Student.new
  end

  def edit
    @student = Student.new
  end

   def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to students_index_path
    else
      render :edit
    end
  end

   def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_index_path
  end

  def create
    # Find the student by name
    existing_student = current_teacher.students.find_by(name: student_params[:name])

    if existing_student
      # Update existing student's mark
      existing_student.update(mark: student_params[:mark])
      flash[:notice] = "Student's mark updated successfully."
    else
      # Create a new student
      @student = current_teacher.students.new(student_params)

      if @student.save
        flash[:notice] = "Student created successfully."
      else
        flash[:alert] = "Error creating student."
      end
    end
    redirect_to students_index_path
  end
  
  private

    def student_params
       params.require(:student).permit(:name, :subject, :mark, :teacher_id)
    end

end
