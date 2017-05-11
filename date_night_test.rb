gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'date_night'

class NodeTest < Minitest::Test
  def test_node_has_title
    dark_night = Node.new(80, "Dark Night")
    assert_equal "Dark Night", dark_night.title
  end
  def test_node_can_have_different_title
    batman_begins= Node.new(60, "Batman Begins")
    assert_equal "Batman Begins", batman_begins.title
  end
  def test_node_has_score
    dark_night = Node.new(80, "Dark Night")
    assert_equal 80, dark_night.score
  end
  def test_node_can_have_different_score
    batman_begins = Node.new(60, "Batman Begins")
    assert_equal 60, batman_begins.score
  end
end

class BinarySearchTreeTest < Minitest::Test
  def test_inserts_node_with_title_and_score
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    assert_equal 60, new_tree.root.score
    assert_equal "Batman Begins", new_tree.root.title
  end
  def test_inserts_lower_node_left
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(50, "Italian Job")
    assert_equal 50, new_tree.root.left.score
  end
  def test_inserts_higher_node_right
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(80, "Dark Night")
    assert_equal 80, new_tree.root.right.score
  end
  def test_inserts_3_lower_nodes_left
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(50, "Italian Job")
    new_tree.insert(25, "Daredevil")
    assert_equal 25, new_tree.root.left.left.score
  end
  def test_inserts_3_higher_nodes_right
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(80, "Dark Night")
    new_tree.insert(90, "Lion King")
    assert_equal 90, new_tree.root.right.right.score
  end
  def test_insert_returns_depth
    new_tree = BinarySearchTree.new
    assert_equal 0, new_tree.insert(60, "Batman Begins")
    assert_equal 1, new_tree.insert(80, "Dark Night")
    assert_equal 2, new_tree.insert(90, "Lion King")
  end
  def test_insert_returns_depth_not_in_order
    new_tree = BinarySearchTree.new
    assert_equal 0, new_tree.insert(80, "Dark Night")
    assert_equal 1, new_tree.insert(60, "Batman Begins")
    assert_equal 1, new_tree.insert(90, "Lion King")
    assert_equal 2, new_tree.insert(50, "Italian Job")
  end
  def test_include_true_for_inserted_movies
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(80, "Dark Night")
    new_tree.insert(90, "Lion King")
    assert_equal true, new_tree.include?(60)
    assert_equal true, new_tree.include?(80)
    assert_equal true, new_tree.include?(90)
  end
  def test_include_false_for_nonexisting_movies
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    assert_equal false, new_tree.include?(80)
  end
  def test_depth_of_returns_depth
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(80, "Dark Night")
    new_tree.insert(90, "Lion King")
    assert_equal 0, new_tree.depth_of(60)
    assert_equal 1, new_tree.depth_of(80)
    assert_equal 2, new_tree.depth_of(90)
  end
  def test_depth_of_returns_nil_for_nonexisting_score
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    assert_nil new_tree.depth_of(80)
  end
  def test_max_returns_highest_score_and_movie
    new_tree = BinarySearchTree.new
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(80, "Dark Night")
    new_tree.insert(90, "Lion King")
    assert_equal ({"Lion King"=>90}), new_tree.max
  end
  def test_min_returns_lowest_score_and_movie
    new_tree = BinarySearchTree.new
    new_tree.insert(80, "Dark Night")
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(90, "Lion King")
    assert_equal ({"Batman Begins"=>60}), new_tree.min
  end
  def test_sort_returns_sorted_movies
    new_tree = BinarySearchTree.new
    new_tree.insert(80, "Dark Night")
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(90, "Lion King")
    new_tree.insert(50, "Italian Job")
    assert_equal [{"Italian Job"=>50}, {"Batman Begins"=>60}, {"Dark Night"=>80}, {"Lion King"=>90}], new_tree.sort
  end
  def test_load_inserts_movies_from_text_file
    new_tree = BinarySearchTree.new
    new_tree.load('movies.txt')
    assert_equal "The Saint", new_tree.search(82, new_tree.root).title
    assert_equal "Breathe", new_tree.search(30, new_tree.root).title
    assert_equal "Serenity", new_tree.search(72, new_tree.root).title
  end
  def test_load_returns_number_inserted
    new_tree = BinarySearchTree.new
    assert_equal 99, new_tree.load('movies.txt')
  end 
  def test_load_ignores_score_already_present
    new_tree = BinarySearchTree.new
    new_tree.insert(82, "Dark Night")
    new_tree.load('movies.txt')
    assert_equal "Dark Night", new_tree.search(82, new_tree.root).title
    refute_equal "The Saint", new_tree.search(82, new_tree.root).title
  end 
  def test_health_returns_expected_values
    new_tree = BinarySearchTree.new
    new_tree.insert(80, "Dark Night")
    new_tree.insert(60, "Batman Begins")
    new_tree.insert(90, "Lion King")
    new_tree.insert(50, "Italian Job")
    assert_equal [[80, 3, 100]], new_tree.health(0)
    assert_equal [[60, 1, 25], [90, 0, 0]], new_tree.health(1)
  end 
end
