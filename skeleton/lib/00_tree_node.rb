class PolyTreeNode

    attr_reader :parent, :value
    attr_accessor :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(par)
        old_parent = self.parent
        old_parent.children.reject! {|el| el == self} if old_parent  
        @parent = par
        par.children << self if par
    end

    def add_child(child)
        child.parent = self 
    end

    def inspect
        value
    end

    def remove_child(child)
        raise "node is not a child" if !children.include?(child)
        child.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        children.each do |child|
            node = child.dfs(target)
            if !node.nil?
                return node if node.value == target
            end
        end
        nil
    end

    def bfs(target)
        queue = [self]
        
        until queue.empty?
            ele = queue.shift
            return ele if ele.value == target
            queue += ele.children
        end
        nil
    end
end

