require_relative "node"

class LinkedList
    attr_reader :size, :head, :tail

    def initialize
        @size = 0
        @head = nil
        @tail = nil
    end

    def append(val)
        node = Node.new(val)
        @head ? @tail.next_node = node : @head = node
        @tail = node
        @size += 1
    end

    def prepend(val)
        if @head
            node = Node.new(val,@head)
            @head = node
        else
            node = Node.new(val)
            @head = node
            @tail = node
        end
        @size += 1
    end

    def at(i)
        i = @size - (i*-1) if i < 0
        return "Error: Invalid index." if i < 0 || i >= @size
        current_el = @head
        it = 0
        while it < i
            current_el = current_el.next_node
            it += 1
        end
        return current_el.value
    end

    def print_list
        current_el = @head
        print "["
        while current_el
            print ", " if current_el != @head
            print current_el.value
            current_el = current_el.next_node
        end
        print "]\n"
    end

    def pop
        return_el = @tail.value 
        @size -= 1
        current_el = @head
        i = 0
        while i < @size-1
            current_el = current_el.next_node
            i += 1
        end
        current_el.next_node = nil
        @tail = current_el
        return return_el
    end

    def shift
        return_el = @head.value 
        @size -= 1
        @head = @head.next_node
        return return_el 
    end

    def contains?(val)
        current_el = @head
        while current_el
            return true if current_el.value == val
            current_el = current_el.next_node
        end
        return false
    end

    def find(data)
        current_el = @head
        it = 0
        while current_el
            return it if current_el.value == data
            current_el = current_el.next_node
            it += 1
        end
        return nil
    end

    def to_s
        current_el = @head
        while current_el
            print " -> " if current_el != @head
            print "( #{current_el.value} )"
            current_el = current_el.next_node
        end
        print " -> nil\n"
    end

    def insert_at(index,data)
        index = @size - (index*-1) if index < 0
        return "Error: Invalid index." if index < 0 || index >= @size
        if index == 0
            self.prepend(data)
        elsif index == @size-1
            self.append(data)
        else
            current_el = @head
            it = 0
            inserted = false
            while current_el && inserted == false
                if it == index - 1
                    #hold = current_el.next_node
                    current_el.next_node = Node.new(data,current_el.next_node)
                    inserted = true
                    next
                else
                    current_el = current_el.next_node
                end
                it += 1
            end
            @size += 1
        end
    end

    def remove_at(index)
        index = @size - (index*-1) if index < 0
        return "Error: Invalid index." if index < 0 || index >= @size
        if index == 0
            self.shift
        elsif index == @size-1
            self.pop
        else
            current_el = @head
            it = 0
            removed = false
            while current_el && removed == false
                if it == index-1
                    hold = current_el.next_node
                    current_el.next_node = hold.next_node
                    removed = true
                    next
                else
                    current_el = current_el.next_node
                end
                it += 1
            end
            @size -= 1
        end
    end
end

list = LinkedList.new

list.append(2)
list.prepend(1)
list.append(3)
list.prepend(0)
list.append(5)
list.append(30)
list.prepend(40)

list.print_list

p list.size

p list.at(-1)

popped = list.pop
p popped

list.print_list

p list.size

p list.head.value
p list.tail.value

p list.contains?(1)
p list.find(3)

list.insert_at(3,"inserted")
p list.shift
list.remove_at(3)
list.to_s

p list.size
