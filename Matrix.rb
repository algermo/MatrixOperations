#
#  Class that represents a Matrix and implements operations on matrices.
#
#  Author(s): Molly Alger & Katelyn Mulder
#
class Matrix

  # create getter methods for instance variables @rows and @columns
  attr_reader  :rows, :columns

  # create setter methods for instance variables @rows and @columns
  attr_writer  :rows, :columns

  # make setter methods for @rows and @columns private
  private :rows=, :columns=
  
  # method that initializes a newly allocated Matrix object
  # use instance variable named @data (an array) to hold matrix elements
  # raise ArgumentError exception if any of the following is true:
  #     parameters rows or columns or val is not of type Fixnum
  #     value of rows or columns is <= 0
  def initialize(rows=5, columns=5, val=0)

	unless rows.kind_of?(Fixnum) && columns.kind_of?(Fixnum) && val.kind_of?(Fixnum) && rows > 0 && columns > 0
		raise ArgumentError.new("Data is not valid.")
	end

	@rows = rows
	@columns = columns
	@data = Array.new(rows)
	@data.fill {|x| Array.new(columns)}
	for x in 0...rows
		for y in 0...columns
			@data[x][y] = val
		end
	end
  end

  # method that returns matrix element at location (i,j)
  # NOTE: row and column values are zero-index based
  # raise ArgumentError exception if any of the following is true:
  #     parameters i or j is not of type Fixnum
  #     value of i or j is outside the bounds of Matrix
  def get(i, j)

	unless i.kind_of?(Fixnum) && j.kind_of?(Fixnum) && i <= @rows && j <= @columns && i>=0 && j>=0
		raise ArgumentError.new("Rows and columns are not valid.")
	end
	return @data[i][j]

  end

  # method to set the value of matrix element at location (i,j) to value of parameter val
  # NOTE: row and column values are zero-index based
  # raise ArgumentError exception if any of the following is true:
  #     parameters i or j or val is not of type Fixnum
  #     the value of i or j is outside the bounds of Matrix
  def set(i, j, val)

	unless i.kind_of?(Fixnum) && j.kind_of?(Fixnum) && val.kind_of?(Fixnum) && i <= @rows && j <= @columns
                raise ArgumentError.new("Data is not valid.")
	end
	@data[i][j] = val

  end

  # method that returns a new matrix object that is the sum of this and parameter matrices.
  # raise ArgumentError exception if the parameter m is not of type Matrix
  # raise IncompatibleMatricesError exception if the matrices are not compatible for addition operation
  def add(m)
	unless m.kind_of?(Matrix)
		raise ArgumentError.new("Data is not valid.")
	end
	unless @rows == m.rows && @columns == m.columns
		raise IncompatibleMatricesError.new("Matrices cannot be added.")
	end

	result = Matrix.new(@rows, @columns, 0)

	for i in 0..@rows
		for j in 0..@columns
			result.set(i,j,(get(i,j)+m.get(i,j)))
		end
	end
	return result
  end

  # method that returns a new matrix object that is the difference of this and parameter matrices
  # raise ArgumentError exception if the parameter m is not of type Matrix
  # raise IncompatibleMatricesError exception if the matrices are not compatible for subtraction operation
  def subtract(m)
	unless m.kind_of?(Matrix)
                raise ArgumentError.new("Data is not valid.")
	end
        unless @data.rows == m.rows && @data.columns == m.columns
                raise IncompatibleMatricesError.new("Matrices cannot be added.")
	end

        result = Matrix.new(@data.rows, @data.columns, 0)

        for i in 0..@data.rows
                for j in 0..@data.columns
                        result[i][j] = @data[i][j] - m[i][j]
 		end
	end
	return result
  end

  # method that returns a new matrix object that is a scalar multiple of source matrix object
  # raise ArgumentError exception if the parameter k is not of type Fixnum
  def scalarmult(k)
	unless k.kind_of?(Fixnum)
		riase ArgumentError.new("Data is not valid.")
	end

	result = Matrix.new(@data.rows, @data.columns, 0)

        for i in 0..@data.rows
                for j in 0..@data.columns
                        result[i][j] = @data[i][j] * m
        	end
	end
	return result
  end

  # method that returns a new matrix object that is the product of this and parameter matrices
  # raise ArgumentError exception if the parameter m is not of type Matrix
  # raise IncompatibleMatricesError exception if the matrices are not compatible for multiplication operation
  def multiply(m)
	unless m.kind_of?(Matrix)
                raise ArgumentError.new("Data is not valid.")
	end
	unless @data.columns == m.rows
                raise IncompatibleMatricesError.new("Matrices cannot be multiplied.")
 	end

	result = Matrix.new(@data.rows, m.columns, 0)

	for i in 0..result.rows
                for j in 0..result.columns
			val = 0
			for x in 0..@data.columns
				val = val + @data[i][x] * m[x][j]
			end
		end
	end
  end

  # method that returns a new matrix object that is the transpose of the source matrix
  def transpose
	result = Matrix.new(@data.columns, @data.rows, 0)

	for i in 0..@data.rows
                for j in 0..@data.columns
                        result[i][j] = @data[j][i]
        	end
	end
	return result
  end

  # overload + for matrix addition
  def +(m)
    add(m)
  end

  # overload - for matrix subtraction
  def -(m)
    subtract(m)
  end

  # overload * for matrix multiplication
  def *(m)
    multiply(m)
  end

  # class method that returns an identity matrix with size number of rows and columns
  # raise ArgumentError exception if any of the following is true:
  #     parameter size is not of type Fixnum
  #     the value of size <= 0
  def Matrix.identity(size)
	unless size.kind_of?(Fixnum) && size > 0
		raise ArgumentError.new("Data is not valid.")
	end

	result = Matrix.new(size,size,0)

	for i in 0..result.rows
		for j in 0..result.columns
			if i == j
				result[i][j] = 1
			end
		end
	end
  end

  # method that sets every element in the matrix to value of parameter val
  # raise ArgumentError exception if val is not of type Fixnum
  # hint: use fill() method of Array to fill the matrix
  def fill(val)
	unless val.kind_of?(Fixnum)
		raise ArgumentError.new("Data is not valid.")
	end
	

  end

  # method that return a deep copy/clone of this matrix object
  def clone

  end

  # method that returns true if this matrix object and the parameter matrix object are equal
  # (i.e., have the same number of rows, columns, and corresponding values in the two
  # matrices are equal). Otherwise, it returns false.
  # returns false if the parameter m is not of type Matrix
  def ==(m)
	unless m.kind_of?(Matrix)
		return false
	end

  end

  # method that returns a string representation of matrix data in table (row x col) format
  def to_s

  end

  # method that for each element in the matrix yields with information
  # on row, column, and data value at location (i,j)
  def each

  end
  
end

#
# Custom exception class IncompatibleMatricesError
#
class IncompatibleMatricesError < Exception
  def initialize(msg)
    super msg
  end
end

#
#  main test driver
#
def main
  m1 = Matrix.new(3,4,10)
  m2 = Matrix.new(3,4,20)
  m3 = Matrix.new(4,5,30)
  m4 = Matrix.new(3,5,40)

  puts(m1)
  puts(m2)
  puts(m3)
  puts(m4)

  puts(m1.add(m2))

  puts(m1.subtract(m2))

  puts(m1.multiply(m3))

  puts(m2.scalarmult(5))

  puts(Matrix.identity(5))

  puts(m1 + m2)

  puts(m2 - m1)

  puts(m1 * m3)

  puts(m1 + m2 - m1)

  puts(m4 + m2 * m3)

  puts(m1.clone())

  puts(m1.transpose())

  puts("Are matrices equal? #{m1 == m2}")

  puts("Are matrices equal? #{m1 == m3}")

  puts("Are matrices equal? #{m1 == m1}")

  m1.each { |i, j, val|
    puts("(#{i},#{j},#{val})")
  }

  begin
    m1.get(4,4)
  rescue ArgumentError => exp
    puts("#{exp.message} - get failed\n")
  end

  begin
    m1.set(4,5,10)
  rescue ArgumentError => exp
    puts("#{exp.message} - set failed\n")
  end

  begin
    m1.add(m3)
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - add failed\n")
  end

  begin
    m2.subtract(m3)
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - subtract failed\n")
  end

  begin
    m1.multiply(m2)
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - multiply failed\n")
  end

  begin
    m1 + m3
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - add failed\n")
  end

  begin
    m2 - m3
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - subtract failed\n")
  end

  begin
    m1 * m2
  rescue IncompatibleMatricesError => exp
    puts("#{exp.message} - multiply failed\n")
  end

end

# uncomment the following line to run the main() method
 main()
